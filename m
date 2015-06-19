From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 Jun 2015 11:33:13 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <1434678624.4767.22.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>	
 <55827D64.1090307@free-electrons.com> <1434678624.4767.22.camel@dolka.fr>
Message-ID: <5583E1D9.2010002@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 19/06/2015 03:50, Benjamin Cama wrote:
> Hi Gr?gory, Andrew and Arnd,
> 
> Le jeudi 18 juin 2015 ? 10:12 +0200, Gregory CLEMENT a ?crit :
>> On 15/06/2015 15:51, Benjamin Cama wrote:
>>> Also, my intent at first was to try converting this machine to DT, so 
>>> maybe
>>> the solution to my problem would simply be to try converting it and see
>>> if it fixes the problem?
>>
>> Indeed it is your best option given the problem you exposed later in this
>> thread. Our plan in mid-term is to completely remove the non-DT support.
>> So converting the board is definitely the right thing to do.
>>
>> The conversation should not be too hard to achieve, you will have mainly to
>> write a dts, build a dtb an append it to your kernel.
>> You can have a look on waht was done for the LaCie d2 Network platform, see
>> 94b0bd366e36379c994bdaa84f 'ARM: orion5x: convert d2net to Device Tree'
> 
> OK, I tried following you advice, and copied step by step the dts with
> values corresponding to my board.
> 
>> If you have any trouble or question during the conversion we will 
>> help you.
> 
> It took several iterations to get done, but attached is the dts I
> wrote. Still, it doesn't boot and I get no message after the
> decompressor message. But I get something: the leds change according to
> the configuration of the dts, so something is going on (I noticed the
> change after several failed boot where no led changed and fixing a typo
> made it).
> 
> My main problem is getting some debug messages: no amount of "debug"
> and "loglevel" on the command line seems to change anything. Is it too
> early in the boot process to get anything output or am I doing
> something wrong? (I activated some configs for debugging, but I may
> have missed the good one)

Try to activate earlyprintk. For this you have to select CONFIG_EARLY_PRINTK
which depend on DEBUG_LL. You will also have to add the argument
"earlyprintk" to your kernel parameters.

Gregory


> 
> Thanks,
> --
> benjamin
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
