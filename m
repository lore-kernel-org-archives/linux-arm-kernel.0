From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Jul 2013 23:00:44 -0700
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E3BF5@DBDE04.ent.ti.com>
References: <20130702152954.f25bbf51c1a79aa4437e22ee@canb.auug.org.au>
 <20980858CB6D3A4BAE95CA194937D5E73E9E3BF5@DBDE04.ent.ti.com>
Message-ID: <CAOesGMgh=CLCrtohrNF59Sh40-weCorL1_yjFgFKr47qhVy+xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 10:44 PM, Gupta, Pekon <pekon@ti.com> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> Documentation/devicetree/bindings/mtd/gpmc-nand.txt between commits
>> 6c88058ef927 ("ARM: OMAP2+: cleaned-up DT support of various ECC
>> schemes") and 212012138deb ("mtd: nand: omap2: updated support for
>> BCH4
>> ECC scheme") from the l2-mtd tree and commit 496c8a0bbb72 ("ARM:
>> OMAP2+:
>> Allow NAND transfer mode to be specified in DT") from the arm-soc tree.
>>
>> I fixed it up (maybe - see below) and can carry the fix as necessary (no
>> action is required).
>>
>> --
>> Cheers,
>> Stephen Rothwell                    sfr at canb.auug.org.au
>>
> Yes following merge is correct. Apologies, as there were multiple OMAP2 NAND and GPMC updates and clean-up going into different trees, so these conflict came. Going forward you shouldn't find such issues, as code is more stable now. Thanks for help.
>
> with regards, pekon

Sigh. The new bindings seem to never have been reviewed by any device
tree maintainers, and from the look of it, it might need some
discussion. It wasn't even cc:d to devicetree-discuss.

It's completely inappropriate to merge a patch like this at this time
without any kind of acks from the people reviewing bindings. Can it
please be dropped ASAP from the MTD tree? Thanks!

Or, if you want it in different wording: The mtd-tree patch is a
strong NAK until this has been sorted out.

It was also applied today, after the merge window opened. Don't merge
it for 3.11. Artem?


-Olof
