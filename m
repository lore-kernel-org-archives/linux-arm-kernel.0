From: vigneshr@ti.com (R, Vignesh)
Date: Mon, 23 May 2016 14:48:59 +0530
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
In-Reply-To: <20160520163404.GC14951@dtor-ws>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160520163404.GC14951@dtor-ws>
Message-ID: <5742CB03.8010805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/20/2016 10:04 PM, Dmitry Torokhov wrote:
> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
>> There are rotary-encoders where GPIO lines reflect the actual position
>> of the rotary encoder dial. For example, if dial points to 9, then four
>> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
>> Add support for such rotary-encoder.
>> The driver relies on rotary-encoder,absolute-encoder DT property to
>> detect such encoders.
>> Since, GPIO IRQs are not necessary to work with
>> such encoders, optional polling mode support is added using
>> input_poll_dev skeleton. This is can be used by enabling
>> CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT.
> 
> Does this really belong to a rotary encoder and not a new driver that
> simply translates gpio-encoded value into ABS* event?
> 

Currently rotary encoder driver only supports incremental/step counting
rotary devices. However, the device that is there on am335x-ice is an
absolute encoder but, IMO, nevertheless a kind of rotary encoder. The
only difference is that there is no need to count steps and the absolute
position value is always available as binary encoded state of connected
GPIOs.
The hardware on am335x-ice is a mechanical rotary encoder switch
connected over 4 GPIOs. It is same as binary encoder described at [1]
(except there are 4 GPIO lines), so this lead me to add support in
rotary-encoder.

[1]https://en.wikipedia.org/wiki/Rotary_encoder#Standard_binary_encoding
