From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 07 Sep 2014 11:19:19 +0200
Subject: [PATCH 1/2] ARM: mvebu: Netgear RN104: Use Hardware BCH ECC
In-Reply-To: <20140907093851.377ddd29@free-electrons.com> (Thomas Petazzoni's
 message of "Sun, 7 Sep 2014 09:38:51 +0200")
References: <cover.1410035142.git.arno@natisbad.org>
 <920c7e7169dc6aaaa3eb4bced2336d38e77b8864.1410035142.git.arno@natisbad.org>
 <20140907093851.377ddd29@free-electrons.com>
Message-ID: <87oaurg548.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> On Sat, 06 Sep 2014 22:49:25 +0200, Arnaud Ebalard wrote:
>
>> Fixes: 0373a558bd79 ("ARM: mvebu: Enable NAND controller in ReadyNAS 104 .dts file")
>> Depends-on: 5b3e507820c6 ("mtd: nand: pxa3xx: Use ECC strength and step size devicetree binding")
>
> Maybe it's worth noting that it's not a build dependency: your commit
> changing the Device Tree files can perfectly be applied without the
> NAND ECC strength and step size bindings. Of course, it will have no
> effect on an older kernel that doesn't support those bindings, but it
> will not cause a build failure.

Yes. To be more explicit, if the patches are candidates for stable, I
think they are only useful for 3.16.y (3.16 is the first kernel with
5b3e507820c6). As you point, backporting down to 3.14 would not hurt
but would only be decorative.

Cheers,

a+
