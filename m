From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 18 Jul 2017 13:59:59 +0200
Subject: [PATCH v2 0/7] [PATCH v2 0/7] Add support of OV9655 camera
In-Reply-To: <8157da84-1484-8375-1f2b-9831973915b4@kernel.org>
References: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
 <8157da84-1484-8375-1f2b-9831973915b4@kernel.org>
Message-ID: <956f17e6-36dd-6733-0d35-9b801ed4244d@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/17 22:01, Sylwester Nawrocki wrote:
> Hi Hugues,
> 
> On 07/03/2017 11:16 AM, Hugues Fruchet wrote:
>> This patchset enables OV9655 camera support.
>>
>> OV9655 support has been tested using STM32F4DIS-CAM extension board
>> plugged on connector P1 of STM32F746G-DISCO board.
>> Due to lack of OV9650/52 hardware support, the modified related code
>> could not have been checked for non-regression.
>>
>> First patches upgrade current support of OV9650/52 to prepare then
>> introduction of OV9655 variant patch.
>> Because of OV9655 register set slightly different from OV9650/9652,
>> not all of the driver features are supported (controls). Supported
>> resolutions are limited to VGA, QVGA, QQVGA.
>> Supported format is limited to RGB565.
>> Controls are limited to color bar test pattern for test purpose.
> 
> I appreciate your efforts towards making a common driver but IMO it would be 
> better to create a separate driver for the OV9655 sensor.  The original driver 
> is 1576 lines of code, your patch set adds half of that (816).  There are
> significant differences in the feature set of both sensors, there are 
> differences in the register layout.  I would go for a separate driver, we  
> would then have code easier to follow and wouldn't need to worry about possible
> regressions.  I'm afraid I have lost the camera module and won't be able 
> to test the patch set against regressions.
> 
> IMHO from maintenance POV it's better to make a separate driver. In the end 
> of the day we wouldn't be adding much more code than it is being done now.

I agree. We do not have great experiences in the past with trying to support
multiple variants in a single driver (unless the diffs are truly small).

Regards,

	Hans

> 
>>   .../devicetree/bindings/media/i2c/ov965x.txt       |  45 ++
>>   drivers/media/i2c/Kconfig                          |   6 +-
>>   drivers/media/i2c/ov9650.c                         | 816 +++++++++++++++++----
>>   3 files changed, 736 insertions(+), 131 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/ov965x.txt
> 
> --
> Thanks,
> Sylwester
> 
