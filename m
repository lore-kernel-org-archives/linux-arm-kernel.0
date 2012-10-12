From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 12 Oct 2012 14:42:37 +0800
Subject: [PATCH] i2c: change the id to let the i2c device work
In-Reply-To: <20121012055301.GM11726@opensource.wolfsonmicro.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
 <20121012044042.GI11726@opensource.wolfsonmicro.com>
 <5077A33E.4080801@atmel.com>
 <20121012051419.GJ11726@opensource.wolfsonmicro.com>
 <5077AE8C.5040605@atmel.com>
 <20121012055301.GM11726@opensource.wolfsonmicro.com>
Message-ID: <5077BBDD.4010004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2012 13:53, Mark Brown wrote:
> On Fri, Oct 12, 2012 at 01:45:48PM +0800, Bo Shen wrote:
>> On 10/12/2012 13:14, Mark Brown wrote:
>
>>> No, this still makes no sense to me.  This is clearly a non-DT device
>>> registration, what does DT have to do with anything here?  What is the
>
>> Yes, this is non-DT device registration.
>> As the Linux kernel code is transferring to DT which doesn't use
>> platform device id. however here, modified unconsciously. So correct
>> this error.
>
> What error and what does DT have to do with any of this?  DT has no
> impact on non-DT systems.

Yes. This has nothing to do with DT.

>>> practical problem you are seeing in your system and how does this help
>>> with it?
>
>> In non-DT kernel, we use platform device id to distinguish between
>> each device.
>
>> So, in this case, if the id = -1, i2c core will dynamically assign a
>> bus id to this bus when running, the dynamically assigned bus id is
>> unknown when writing the code. So, when we use
>> i2c_register_board_info(int busnum, ...) to register device on
>> busnum. we don't know which value to be use.
>
> The I2C bus number assigned to the controller should be independant of
> the platform device ID used to register the device; a better fix if this
> is an issue would be to update the i2c-gpio driver to allow a fixed bus
> number to be specified in platform data.

Hi Haavard Skinnemoen,
   Do you have any suggestions about this?
   Thanks.

BRs,
Bo Shen
