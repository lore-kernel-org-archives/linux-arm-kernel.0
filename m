From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 12 Jul 2013 09:52:35 +0530
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <10406176.2lc5qJ8Oq7@thinkpad>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <20130711104804.GK24508@sirena.org.uk>
 <10406176.2lc5qJ8Oq7@thinkpad>
Message-ID: <CAAgF-BdTY3x9Hb9HmTm6WBrpES7QdKO_VbxN_9zu6zf43AaGQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 4:37 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Thursday 11 of July 2013 11:48:04 Mark Brown wrote:
>> On Thu, Jul 11, 2013 at 12:38:24PM +0530, Padmavathi Venna wrote:
>> > -#define MOD_LR_LLOW                (0 << 7)
>> > -#define MOD_LR_RLOW                (1 << 7)
>> > -#define MOD_SDF_IIS                (0 << 5)
>> > -#define MOD_SDF_MSB                (1 << 5)
>> > -#define MOD_SDF_LSB                (2 << 5)
>> > -#define MOD_SDF_MASK               (3 << 5)
>> >
>> > +#define MOD_LR_LLOW                0
>> > +#define MOD_LR_RLOW                1
>> > +#define MOD_SDF_SHIFT              5
>> > +#define MOD_SDF_IIS                0
>> > +#define MOD_SDF_MSB                1
>> > +#define MOD_SDF_LSB                2
>> > +#define MOD_SDF_MASK               3
>>
>> This patch has an awful lot of coding style changes like this which
>> are just coding style changes and not implementing TDM support.  These
>> should be done separately, not as part of the same patch, in order to
>> make the code easier to review.
>>
>> >     case 768:
>> > -           mod |= MOD_RCLK_768FS;
>> > +           mod |= (MOD_RCLK_768FS << rfs_shift);
>> >
>> >             break;
>>
>> This stuff is another example.
>>
>> I think the change itself should be fine but I'm not 100% sure I'm
>> correctly identifying what's a stylistic change and what's a functional
>> change.
>
> Right. This could be split into two patches, first reworking the style to give
> more flexibility with operations on registers and another one adding TDM
> specific changes, like new bitfield definitions and conditional handling of
> register accesses to account for new bitfield locations.
>
> Best regards,
> Tomasz
>

Ok. I will bisect the changes into two patches as suggested.

Thanks
Padma
