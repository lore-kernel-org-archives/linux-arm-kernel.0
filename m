From: hugues.fruchet@st.com (Hugues FRUCHET)
Date: Mon, 26 Jun 2017 10:05:41 +0000
Subject: [PATCH v1 0/6] Add support of OV9655 camera
In-Reply-To: <385A82AC-CC23-41BD-9F57-0232F713FED9@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <385A82AC-CC23-41BD-9F57-0232F713FED9@goldelico.com>
Message-ID: <cb9bcc6e-4bc8-7eaa-3d15-6e16e22226f2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

On 06/22/2017 05:41 PM, H. Nikolaus Schaller wrote:
> 
>> Am 22.06.2017 um 17:05 schrieb Hugues Fruchet <hugues.fruchet@st.com>:
>>
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
>>
>> OV9655 initial support is based on a driver written by H. Nikolaus Schaller [1].
> 
> Great!
> 
> I will test as soon as possible.
> 

Many thanks for your active review and testing Nikolaus !

>> OV9655 registers sequences come from STM32CubeF7 embedded software [2].
> 
> There is also a preliminary data sheet, e.g. here:
> 
> http://electricstuff.co.uk/OV9655-datasheet-annotated.pdf

This is the datasheet I've used for registers naming and signification.

BR,
Hugues.
> 
>>
>> [1] http://git.goldelico.com/?p=gta04-kernel.git;a=shortlog;h=refs/heads/work/hns/video/ov9655
>> [2] https://developer.mbed.org/teams/ST/code/BSP_DISCO_F746NG/file/e1d9da7fe856/Drivers/BSP/Components/ov9655/ov9655.c
>>
>> ===========
>> = history =
>> ===========
>> version 1:
>>   - Initial submission.
>>
>> H. Nikolaus Schaller (1):
>>   DT bindings: add bindings for ov965x camera module
>>
>> Hugues Fruchet (5):
>>   [media] ov9650: add device tree support
>>   [media] ov9650: select the nearest higher resolution
>>   [media] ov9650: use write_array() for resolution sequences
>>   [media] ov9650: add multiple variant support
>>   [media] ov9650: add support of OV9655 variant
>>
>> .../devicetree/bindings/media/i2c/ov965x.txt       |  37 +
>> drivers/media/i2c/Kconfig                          |   6 +-
>> drivers/media/i2c/ov9650.c                         | 792 +++++++++++++++++----
>> 3 files changed, 704 insertions(+), 131 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/media/i2c/ov965x.txt
>>
>> -- 
>> 1.9.1
>>
> 
> BR and thanks,
> Nikolaus Schaller
> 
