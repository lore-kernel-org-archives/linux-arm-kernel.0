From: robert.daniels@vantagecontrols.com (Robert Daniels)
Date: Wed, 24 Jun 2015 17:10:26 +0000
Subject: L2 Cache enable on i.MX5
Message-ID: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


?I recently discovered an issue with an i.MX53 based product where we had an older version of Das U-Boot which disabled the L2 cache on startup but in a later version would re-enable it once the L2 cache was configured. Since we had the version that did not re-enable it, we run our Linux kernel with the L2 cache disabled.

I'd like to have the Linux kernel enable the L2 cache on initialization - where is the correct place to do this? Currently, I've added it to the initialization assembly in arch/arm/boot/compressed/head.S for the decompress kernel loader to get the cache enabled as soon as possible but I wonder if there's a better place.

Once I get things squared away, I can submit this patch to the list to have it added to the kernel.

Thanks,

Robert Daniels



________________________________

Ce message, ainsi que tous les fichiers joints ? ce message, peuvent contenir des informations sensibles et/ ou confidentielles ne devant pas ?tre divulgu?es. Si vous n'?tes pas le destinataire de ce message (ou que vous recevez ce message par erreur), nous vous remercions de le notifier imm?diatement ? son exp?diteur, et de d?truire ce message. Toute copie, divulgation, modification, utilisation ou diffusion, non autoris?e, directe ou indirecte, de tout ou partie de ce message, est strictement interdite.
Se d?sabonner: Si vous souhaitez ?tre retir? de notre liste de diffusion, s'il vous pla?t envoyer vos coordonn?es ? CASL.unsubscribe at legrand.ca<mailto:casl.unsubscribe@legrand.ca> et indiquer quels sont les messages que vous ne souhaitez plus recevoir.


This e-mail, and any document attached hereby, may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized, direct or indirect, copying, disclosure, distribution or other use of the material or parts thereof is strictly forbidden.
Unsubscribe: If you would like to be removed from our mailing list, please send your contact information to CASL.unsubscribe at legrand.ca<mailto:casl.unsubscribe@legrand.ca> and indicate what messages you no longer wish to receive.
