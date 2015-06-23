From: achandran@mvista.com (Arun Chandran)
Date: Tue, 23 Jun 2015 21:08:31 +0530
Subject: BUG: Bad page state in process swapper pfn:XXXXX
In-Reply-To: <20150622151647.GW7557@n2100.arm.linux.org.uk>
References: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
 <20150622151647.GW7557@n2100.arm.linux.org.uk>
Message-ID: <CAFdej03_ddqhOTbmsA-hoxb+te1yXpdHP_wt8_iKyA0DQ9XrFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 8:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 22, 2015 at 08:04:17PM +0530, Arun Chandran wrote:
>> Hi,
>>
>> I am booting the latest linus tree on altera cyclone5 soc development kit.
>> (https://www.altera.com/products/boards_and_kits/dev-kits/altera/kit-cyclone-v-soc.html)
>> With the dtb file arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb.
>>
>> I get these BUGS (page dumped because: non-NULL mapping) randomly; occurs
>> around 1 in 5 times during cold boots.
>
> When did the problem start?  Are older kernel versions stable?
>

It took sometime for me; as the issue is random.  I did bisect with the
conditions

a) All the good commit was tested for more than 25 cold boots
b) Testing of a bad commit stopped as soon as I met with
"BUG: Bad page state in process swapper  pfn:XXXXX"

I found that problem is between v3.13(good) and v3.14(bad) and
the problem commit is "84f452b1e8fc73ac0e31254c66e3e2260ce5263d ARM:
mm: Remove bootmem code and switch to NO_BOOTMEM"

If I boot v3.14 with the above commit reverted, the problem is not seen.

I don't know whether my board lacks any platform code
to support the above commit.

--Arun
