From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Fri, 3 Jun 2016 09:41:53 +0000
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <CAOTQ16KS6RobKfs5MP=Bx2ad6Xipht7VO4CP5DbzQr9T60ip=A@mail.gmail.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
 <1464640806-3942-3-git-send-email-thommyj@gmail.com>
 <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
 <CAOTQ16KS6RobKfs5MP=Bx2ad6Xipht7VO4CP5DbzQr9T60ip=A@mail.gmail.com>
Message-ID: <HE1PR0401MB18663F72E21C5E237E0F2D2FE6590@HE1PR0401MB1866.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Thommy Jakobsson [mailto:thommyj at gmail.com] 
Sent: Friday, June 03, 2016 2:32 PM
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org; robin.murphy at arm.com; will.deacon at arm.com
Subject: Re: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs

>>[Gupta Nipun] I should start from 0 and should be incremented in the while loop.
>>[Gupta Nipun] Should this not be 'master->cfg.streammasks[i] = 
>>streammask
Good catch Gupta, thanks. Merging to latest linus tree obviously went wrong. Should of_for_each_phandle work?
I had problems with that so I backed out and moved back to while of_parse_phandle_with_args. But parsing of mmu-masters seems to use of_for_each_phandle
[Gupta Nipun] I am not an expert in this, but I do not see any reason for 'of_for_each_phandle' to not work.

BR,
Thommy Jakobsson
