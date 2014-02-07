From: cooloney@gmail.com (Bryan Wu)
Date: Fri, 7 Feb 2014 15:43:29 -0800
Subject: [PATCH] ARM: tegra: enable I2C MUX PCA954x
In-Reply-To: <52F56D95.50707@wwwdotorg.org>
References: <1391806412-8561-1-git-send-email-pengw@nvidia.com>
 <52F56D95.50707@wwwdotorg.org>
Message-ID: <CAK5ve-+3xvBXFrWe+zDX90SA6Tnw4PNbqfFhR4-Wfksd7HmA_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 3:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 02/07/2014 01:53 PM, Bryan Wu wrote:
>> Cardhu has a PCA9546 for I2C bus extension, which connects to 3
>> cameras. It's required for Tegra V4L2 soc camera driver and camera
>> sensor drivers.
>
>>  arch/arm/boot/dts/tegra30-cardhu.dtsi | 8 ++++++++
>>  arch/arm/configs/tegra_defconfig      | 1 +
>
> DT and defconfig changes go into separate branches. Could I get this
> split into two patches please?
>
>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
>
>> +             /* NXP PCA9546 I2C Mux */
>
> That comment isn't useful, since the compatible value below spells out
> what the device is.
>
>> +             pca9546 at 70 {
>
> DT nodes should be named after the class/type of device, not the
> identify. As such, use "i2cmux at 70".
>

OK, cool. I will take all the comments and post my V2 patches.
