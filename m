From: rockford@yandex.ru (=?koi8-r?B?8MHOz9cg4c7E0sXK?=)
Date: Mon, 16 Mar 2015 16:37:48 +0300
Subject: Bug in drivers/net/ethernet/freescale/fec_main.c,
 TX is broken. In 4.0.0-rc3
In-Reply-To: <BLUPR03MB373A446E2D97992CA7AAA32F5020@BLUPR03MB373.namprd03.prod.outlook.com>
References: <390621425930628@web28o.yandex.ru>
 <3625951426018334@web26j.yandex.ru>
 <BLUPR03MB373A446E2D97992CA7AAA32F5020@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <726281426513068@web10o.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

16.03.2015, 12:21, "fugang.duan at freescale.com" <fugang.duan@freescale.com>:
>
> I try your case on i.MX6q sabresd board with net tree kernel.
> root at freescale ~$ uname -r
> 4.0.0-rc3-11071-gf00bbd2
>
> With below test steps for 10 time, the zero file size range from 20M to 300M bytes,
> compare the md5sum checksum between i.MX6q and i.MX6q/PC host, ?the checksum is the same.
>
> root at freescale ~$ rm zeros
> root at freescale ~$ dd if=/dev/zero of=zeros bs=1M count=300
> 300+0 records in
> 300+0 records out
> 314572800 bytes (300.0MB) copied, 1.811459 seconds, 165.6MB/s
> root at freescale ~$ md5sum -b zeros
> 0d97a9cd8bbd7ce75a2a76bb06258915 ?zeros
> root at freescale ~$ cp zeros /mnt/nfs/ -f
> root at freescale ~$ rm zeros
> root at freescale ~$ cp /mnt/nfs/zeros ./
> root at freescale ~$ md5sum -b zeros
> 0d97a9cd8bbd7ce75a2a76bb06258915 ?zeros
>
> Do you have any lost for reproduce the issue ?

Current net tree does not have this issue, it works fine. Thanks to all.

>From git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git

apx at astra:~$ uname -r
4.0.0-rc3-00150-g10640d3-dirty


--
 ??????
