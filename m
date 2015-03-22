From: rockford@yandex.ru (=?koi8-r?B?8MHOz9cg4c7E0sXK?=)
Date: Sun, 22 Mar 2015 23:08:01 +0300
Subject: Bug in drivers/net/ethernet/freescale/fec_main.c,
 TX is broken. In 4.0.0-rc3
In-Reply-To: <CAOMZO5BnPQTFoBRr4EGH24_yZZAY6NJmVFg4WeiJcTqrYqki5A@mail.gmail.com>
References: <390621425930628@web28o.yandex.ru>
 <3625951426018334@web26j.yandex.ru>
 <BLUPR03MB373A446E2D97992CA7AAA32F5020@BLUPR03MB373.namprd03.prod.outlook.com>
 <726281426513068@web10o.yandex.ru>
 <BLUPR03MB3739B9C6E14A106CCAEBA32F5020@BLUPR03MB373.namprd03.prod.outlook.com>
 <994171426532944@web7m.yandex.ru>
 <20150321205359.GM8656@n2100.arm.linux.org.uk>
 <CAOMZO5BnPQTFoBRr4EGH24_yZZAY6NJmVFg4WeiJcTqrYqki5A@mail.gmail.com>
Message-ID: <8321261427054881@web25h.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

22.03.2015, 01:35, "Fabio Estevam" <festevam@gmail.com>:
> Hi Russell,
>
> On Sat, Mar 21, 2015 at 5:53 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> ?Given that this bug can seriously screw data up in undetectable ways (TCP
>> ?checksums don't save you, because the FEC generates them on the data which
>> ?it read from memory, even if it happened to read the data from the SoC's
>> ?boot ROM) we do need to get this fixed ASAP.
>
> Current mainline has 2b995f63987013 reverted, so 4.0-rc5 will not have
> this corruption problem.

I've tested with current mainline and with mainline+2b995f63987013 commit with Russell's
fix and it both works fine, without corruption.

--
 ??????
