From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 31 Jan 2013 00:22:24 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that kirkwood_ge0[01]_init()
 finds its clock
In-Reply-To: <20130130230100.GV7717@titan.lakedaemon.net>
References: <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
Message-ID: <5109AB30.5020202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 12:01 AM, Jason Cooper wrote:
> As it stands, there are three patches to fix this issue:
>
> ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency
> ARM: kirkwood: provide ge clock aliases for shared smi
> ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels

Actually, for the second patch I got distracted by the smi split patch
set floating around. But that is not in current kernel and smi will not
request any clock at all.

If Simon can hit another round of testing without second patch included
and agrees, I suggest to keep it for next release.

> wrt to ge losing mac addresses, both DT and non-DT booting are covered by
> Sebastian's patches, for non-DT aware mv643xx_eth.

non-DT already ungates ge0/1 clocks on registration and cannot loose its
mac address, not my fix.

Sebastian
