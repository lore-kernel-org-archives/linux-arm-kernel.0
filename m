From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 15 Feb 2011 09:54:09 +0100
Subject: [PATCH v2] ARM: S5PV210: Add GONI board setup for CIF camera
	support
In-Reply-To: <008d01cbccd4$3897da00$a9c78e00$%kim@samsung.com>
References: <1297445273-3829-1-git-send-email-s.nawrocki@samsung.com>
	<008d01cbccd4$3897da00$a9c78e00$%kim@samsung.com>
Message-ID: <4D5A3F31.1070106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 02/15/2011 06:50 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> Hello,
>>
> Hi,
> 
>> the following patch series introduces changes in GONI board setup file
>> required for the CIF camera sensor driver.
>> The first patch adds the I2C0 bus driver, the second one adds the
> regulator
>> supply definitions and the third one just increases virtual size
>> of the framebuffer window 0 to enable double-buffering.
>> The added regulator supplies are also a subset of the supplies of the high
>> resolution camera which that reference board is equipped with.
>>
>> Changes since v1:
>>  - removed unnecessary "select CONFIG_S3C_DEV_I2C0"
>>
>>
>> The patch series contains:
>>
>> [PATCH 1/3] ARM: S5PV210: Enable I2C0 bus on GONI board
>> [PATCH 2/3] ARM: S5PV210: Add supplies for CIF camera on GONI board
>> [PATCH 3/3] ARM: S5PV210: Change framebuffer window 0 size on GONI
>>
>> Created against for-next branch at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>>
> Hmm...looks you don't want to follow my suggestion on 2nd patch.

I've attempted to make a change as you suggested but it turned out
that all regulators I'm adding supplies for in the second patch are
also used by the other, high resolution camera. It's not about I don't
want to follow you suggestions. The argument is that I's like to add shortly
support for the other camera and then the patch would be just one line
per a power supply rather than 4. I really don't mind to adhere to your
preferred style. But in this case it would be just more work to revert
things back and forth.

I've boot tested your patch:
ARM: S5PV210: Use REGULATOR_SUPPLY macro for regulator consumers
on Aquila and GONI board altogether with my changeset.

> 
> I'm still wondering why array is needed for just one member in
> regulator_consumer_supply structure now even though other something will be
> added later.
> 
> Nevertheless will apply your 3 patches but if not required array will be
> removed later.

Thanks! I am going to post further patches for this board soon so there
should be no need to change anything. Please use you time for more important
things ;)

I've noticed one issue with the first patch, i.e. Kyungmin's email address
is broken. Should I resend the patch or could you please correct this on your side?

Thanks,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
