From: thommyj@gmail.com (Thommy Jakobsson)
Date: Fri, 3 Jun 2016 11:02:00 +0200
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
 <1464640806-3942-3-git-send-email-thommyj@gmail.com>
 <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
Message-ID: <CAOTQ16KS6RobKfs5MP=Bx2ad6Xipht7VO4CP5DbzQr9T60ip=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>[Gupta Nipun] I should start from 0 and should be incremented in the while loop.
>>[Gupta Nipun] Should this not be 'master->cfg.streammasks[i] = streammask
Good catch Gupta, thanks. Merging to latest linus tree obviously went
wrong. Should of_for_each_phandle work?
I had problems with that so I backed out and moved back to while
of_parse_phandle_with_args. But parsing
of mmu-masters seems to use of_for_each_phandle

BR,
Thommy Jakobsson
