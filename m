From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 22 Feb 2017 15:52:50 -0800
Subject: [PATCH v4 33/36] media: imx: redo pixel format enumeration and
 negotiation
In-Reply-To: <1487244744.2377.38.camel@pengutronix.de>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-34-git-send-email-steve_longerbeam@mentor.com>
 <1487244744.2377.38.camel@pengutronix.de>
Message-ID: <9a4a4da7-418e-860e-05ec-da44b3c945cc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,


On 02/16/2017 03:32 AM, Philipp Zabel wrote:
> On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
>> The previous API and negotiation of mbus codes and pixel formats
>> was broken, and has been completely redone.
>>
>> The negotiation of media bus codes should be as follows:
>>
>> CSI:
>>
>> sink pad     direct src pad      IDMAC src pad
>> --------     ----------------    -------------
>> RGB (any)        IPU RGB           RGB (any)
>> YUV (any)        IPU YUV           YUV (any)
>> Bayer              N/A             must be same bayer code as sink
>
> The IDMAC src pad should also use the internal 32-bit RGB / YUV format,
> except if bayer/raw mode is selected, in which case the attached capture
> video device should only allow a single mode corresponding to the output
> pad media bus format.

The IDMAC source pad is going to memory, so it has left the IPU.
Are you sure it should be an internal IPU format? I realize it
is linked to a capture device node, and the IPU format could then
be translated to a v4l2 fourcc by the capture device, but IMHO this
pad is external to the IPU.

Steve
