From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 26 Jan 2017 20:07:47 +0000
Subject: [PATCHv3 4/5] arm: mvebu: Add device tree for 98DX3236 SoCs
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-5-chris.packham@alliedtelesis.co.nz>
 <87inp1zwlg.fsf@free-electrons.com>
Message-ID: <3493169361fe445ba971951b40360301@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/17 04:10, Gregory CLEMENT wrote:
> Hi Chris,
>
>  On ven., janv. 06 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>
>> The Marvell 98DX3236, 98DX3336, 98DX4521 and variants are switch ASICs
>> with integrated CPUs. They are similar to the Armada XP SoCs but have
>> different I/O interfaces.
>
> Before sending a new version I have a few remarks:
>
>

[snip]

I'll update the dtsi files to use the node labels and correct the 
commends as requested

>
> Why the following node is not part of the dtsi?
>
> Gregory
>
>> +			resume at 20980 {
>> +				compatible = "marvell,98dx3336-resume-ctrl";
>> +				reg = <0x20980 0x10>;
>> +			};
>> +		};
>> +	};

The 98DX9236 has a single ARMv7 core. As such this resume control isn't 
present on it. The 98DX3336 and 98DX4521 have dual ARMv7 cores and this 
is used to boot the second core (SMP support is a little different 
compared to Armada-XP).

In other words {98DX3336, 98DX4521} = 98DX9236 + an additional core. At 
the switch packet processor level there are more differences but as far 
as the kernel is concerned the only real difference is the number of cores.
