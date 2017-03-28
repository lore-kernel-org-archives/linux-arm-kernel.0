From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 28 Mar 2017 23:26:51 +0200
Subject: [PATCH 1/1] pinctrl: meson: meson8b: fix the NAND DQS pins
In-Reply-To: <m2shlxa15t.fsf@baylibre.com>
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170325184350.7677-2-martin.blumenstingl@googlemail.com>
 <m2shlxa15t.fsf@baylibre.com>
Message-ID: <CAFBinCDjuZW1FZp5_OfrFfeVeLik8dPEzCgwH6YjNe_OpAJ_rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Mar 28, 2017 at 5:09 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> The nand_groups table uses different names for the NAND DQS pins than
>> the GROUP() definition in meson8b_cbus_groups (nand_dqs_0 vs nand_dqs0).
>> This prevents using the NAND DQS pins in the devicetree.
>>
>> I decided to rename both pins to nand_dqs_15 and nand_dqs_18 as both seem
>> to serve the same function, just exposed on different pins (unlike the
>> ethernet TX pins for example, where there's eth_txd0..3 - all of these
>> can be active at the same time as they are different data lines).
>>
>> Fixes: 0fefcb6876d0 ("pinctrl: Add support for Meson8b")
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> IMO, the fix should be a separate from the rename, since one is a fix
> for a real issue and the other is cosmetic.
actually the idea behind that was not to change what we expose to
devicetree twice (one kernel release contains the "fix", the next
release includes a rename). but actually your suggestion makes sense:
having two patches doesn't meant that they have to go into different
kernel releases (I'll explicitly state that they both should be
applied together, with a reference to this mail).

I'll split and re-send this in the next few days


Regards,
Martin
