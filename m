From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Sun, 13 Jul 2014 20:55:42 -0700
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <CAB8gEUvEQdRT3Xarq_z6-KCr3T9xZ7wHvW9Termw8MAg_d-gQA@mail.gmail.com>
References: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
 <CAB8gEUv52mjpAuYRKhv8_VuAwt9Uog5eD2jn45gnyqcd+cXv8g@mail.gmail.com>
 <20140708102142.0f7fe796@free-electrons.com>
 <CAB8gEUvEQdRT3Xarq_z6-KCr3T9xZ7wHvW9Termw8MAg_d-gQA@mail.gmail.com>
Message-ID: <CAB8gEUuQUT_Ku8E2hg68OqVMH+ZF2E7hRYKAk5954K7eXbNGyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
Good day.

Any update on my previous inquiry?
Thank you.

Regards,
Maggie Roxas

On Tue, Jul 8, 2014 at 11:35 PM, Maggie Mae Roxas
<maggie.mae.roxas@gmail.com> wrote:
> Hi Thomas,
> Good day.
>
> As much as we'd like to switch to the latest v3.14.x, we need to stay
> at kernel v3.13.9 as that is a hard requirement of our customer (I
> think it's because it's the base platform for Ubuntu 14.04 FS which
> we'll use).
>
> So I applied your patch in our v3.13.9 as suggested:
> http://kernel.opensuse.org/cgit/kernel/patch/?id=cd71e246c16b30e3f396a85943d5f596202737ba
>
> Unfortunately, issue still exists after we applied it.
>
>> Basically, between 3.13.5 and 3.13.9, I introduced two patches to the
> network driver:
>
> Given this, we tried to replace mvneta.c of our v3.13.9 and replace it
> with v3.13.5's mvneta.c.
> Issue does not exist when we did that - but of course, we surely will
> miss something, so we wanted to confirm this further with you.
> It seems like applying cd71e246c16b30e3f396a85943d5f596202737ba in
> v3.13.9 is not sufficient enough..?
> Possibly there are v3.13.5 and v3.13.9 diff (see attached) needed
> apart from just cd71e246c16b30e3f396a85943d5f596202737ba?
>
>> Thanks again for your report!
> No problem. We're also thankful for your support!
>
> Regards,
> Maggie Roxas
>
> On Tue, Jul 8, 2014 at 1:21 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
>> Dear Maggie Mae Roxas,
>>
>> On Mon, 7 Jul 2014 19:27:22 -0700, Maggie Mae Roxas wrote:
>>> Sorry, correcting typo:
>>>
>>> - 3.13.9 (issue exists)
>>> - 3.10.24 (issue does NOT exist)
>>> - 3.13.5 (issue does NOT exist)
>>
>> Ok, thanks again for the report. Unfortunately, you're hitting a known
>> problem that was fixed, but after the 3.13-stable cycle was closed.
>> Basically, between 3.13.5 and 3.13.9, I introduced two patches to the
>> network driver:
>>
>> $ git slog --author=free-electrons v3.13.5..v3.13.9
>> 396b229b683fdc08d8705883860ec5a1b810546a net: mvneta: fix usage as a module on RGMII configurations
>> ea64e1f33d9d627da5d38da035e5d7443276e84e net: mvneta: rename MVNETA_GMAC2_PSC_ENABLE to MVNETA_GMAC2_PCS_ENABLE
>>
>> To fix the usage of mvneta on RGMII configurations. However, by doing
>> so, I broke SGMII configurations. So, I sent a patch to revert "net:
>> mvneta: fix usage as a module on RGMII configurations", which was
>> accepted. But in the mean time, the 3.13-stable cycle was closed, so
>> this revert was never merged in the 3.13.x series.
>>
>> If you want to stay on 3.13.x, you should therefore apply:
>>
>> cd71e246c16b30e3f396a85943d5f596202737ba Revert "net: mvneta: fix usage as a module on RGMII configurations"
>>
>> This commit is from the 3.14-stable branch, in Linus master branch,
>> it's:
>>
>> cc6ca3023f2c2bbcd062e9d4cf6afc2ba2821ada Revert "net: mvneta: fix usage as a module on RGMII configurations"
>>
>> Some other commits, merged after that, fix the usage of mvneta as a
>> module on both RGMII and SGMII configurations.
>>
>> Any reason you're still using 3.13.x ? You should really consider
>> switching at least to v3.14.x, which is a long-term version, and
>> therefore still maintained. If you use v3.14.x, all of your bug reports
>> that end up in patches, will ultimately be fixed in v3.14.x.
>>
>> Thanks again for your report!
>>
>> Thomas
>> --
>> Thomas Petazzoni, CTO, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
