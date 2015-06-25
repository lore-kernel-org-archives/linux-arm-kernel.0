From: robert.daniels@vantagecontrols.com (Robert Daniels)
Date: Thu, 25 Jun 2015 16:15:34 +0000
Subject: L2 Cache enable on i.MX5
In-Reply-To: <558BBDD5.3020306@melag.de>
References: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>,
 <20150624172900.GN7557@n2100.arm.linux.org.uk>
 <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>,
 <558BBDD5.3020306@melag.de>
Message-ID: <DBXPR06MB58914F4112C5F73FF89C14A85AE0@DBXPR06MB589.eurprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm working on an mx53, too (tqma53 board), but with an 4.1 kernel.
> How can I check whether L2 cache is enabled ?

I discovered our problem by comparing the version of Das U-Boot we are using
with the latest from Freescale's repository. In this comparison, I discovered that
there had been a patch introduced to enable the L2 cache.  The L2 cache enable
patch is also in the mainline U-Boot source too so if you check in this file:
arch/arm/cpu/armv7/mx5/lowlevel_init.S
around line 49 you should see a comment about enabling the L2 cache. If it's there
you're good to go.

> Can you estimate, how much performance gain we can actually get from the
> L2 cache (under which kind of workloads) ?

In our testing we are seeing a 1.5x - 2.0x improvement. Of course, this may not
affect you at all - we just got unlucky and get our bootloader at the wrong time.

- Robert

________________________________

Ce message, ainsi que tous les fichiers joints ? ce message, peuvent contenir des informations sensibles et/ ou confidentielles ne devant pas ?tre divulgu?es. Si vous n'?tes pas le destinataire de ce message (ou que vous recevez ce message par erreur), nous vous remercions de le notifier imm?diatement ? son exp?diteur, et de d?truire ce message. Toute copie, divulgation, modification, utilisation ou diffusion, non autoris?e, directe ou indirecte, de tout ou partie de ce message, est strictement interdite.
Se d?sabonner: Si vous souhaitez ?tre retir? de notre liste de diffusion, s'il vous pla?t envoyer vos coordonn?es ? CASL.unsubscribe at legrand.ca<mailto:casl.unsubscribe@legrand.ca> et indiquer quels sont les messages que vous ne souhaitez plus recevoir.


This e-mail, and any document attached hereby, may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized, direct or indirect, copying, disclosure, distribution or other use of the material or parts thereof is strictly forbidden.
Unsubscribe: If you would like to be removed from our mailing list, please send your contact information to CASL.unsubscribe at legrand.ca<mailto:casl.unsubscribe@legrand.ca> and indicate what messages you no longer wish to receive.
