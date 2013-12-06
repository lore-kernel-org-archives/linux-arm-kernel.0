From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 10:42:48 -0700
Subject: [PATCH 2/4] ARM: tegra: enable I2C controllers on Venice2
In-Reply-To: <20131206152021.GE32372@ulmo.nvidia.com>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
 <1386196016-25128-2-git-send-email-swarren@wwwdotorg.org>
 <20131206152021.GE32372@ulmo.nvidia.com>
Message-ID: <52A20C98.1010906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 08:20 AM, Thierry Reding wrote:
> On Wed, Dec 04, 2013 at 03:26:54PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> Enable all the I2C controllers that are wired up on Venice2. I
>> don't know the correct I2C bus clock rates, so set them all to a
>> conservative 100KHz for now.
> 
> Perhaps we should only enable those that we really need? I
> currently use these in my local tree:
> 
> i2c at 7000c400: for the trackpad i2c at 7000c700: for HDMI DDC 
> i2c at 7000d000: for the PMIC

All of these I2C buses are used for something. Missing from your list
are e.g.:

i2c at 7000c000 Audio CODEC, temperature sensor
i2c at 7000c500 TPM
