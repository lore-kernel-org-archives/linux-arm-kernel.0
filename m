From: robert.daniels@vantagecontrols.com (Robert Daniels)
Date: Wed, 24 Jun 2015 22:53:01 +0000
Subject: L2 Cache enable on i.MX5
In-Reply-To: <20150624172900.GN7557@n2100.arm.linux.org.uk>
References: <DBXPR06MB5891810D431F1AE9AEB1CE985AF0@DBXPR06MB589.eurprd06.prod.outlook.com>,
 <20150624172900.GN7557@n2100.arm.linux.org.uk>
Message-ID: <DBXPR06MB58911B5FD193722EC5BD34185AF0@DBXPR06MB589.eurprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> I recently discovered an issue with an i.MX53 based product where we had
>> an older version of Das U-Boot which disabled the L2 cache on startup but
>> in a later version would re-enable it once the L2 cache was configured.

> The kernel is supposed to be booted with caches disabled, and in particular,
> the L2 cache disabled during the decompressor run.

> If the L2 cache is configured, it will enable it during it's boot sequence.

I see - so the boot loader is not supposed to enable the L2 cache and it should
not be enabled until after the decompressor runs.

In that case, where should the kernel be enabling the L2 cache? I'm using the
3.14 kernel for this i.MX53 product and the L2 cache is definitely not enabled.

I see that there is a imx_init_l2cache defined which is being called by the imx6
and imx35 platform code but it is not being called for the i.mx5... should it?

Thanks,

Robert Daniels

________________________________

Ce message, ainsi que tous les fichiers joints ? ce message, peuvent contenir des informations sensibles et/ ou confidentielles ne devant pas ?tre divulgu?es. Si vous n'?tes pas le destinataire de ce message (ou que vous recevez ce message par erreur), nous vous remercions de le notifier imm?diatement ? son exp?diteur, et de d?truire ce message. Toute copie, divulgation, modification, utilisation ou diffusion, non autoris?e, directe ou indirecte, de tout ou partie de ce message, est strictement interdite.
Se d?sabonner: Si vous souhaitez ?tre retir? de notre liste de diffusion, s'il vous pla?t envoyer vos coordonn?es ? CASL.unsubscribe at legrand.ca<mailto:casl.unsubscribe@legrand.ca> et indiquer quels sont les messages que vous ne souhaitez plus recevoir.


This e-mail, and any document attached hereby, may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized, direct or indirect, copying, disclosure, distribution or other use of the material or parts thereof is strictly forbidden.
Unsubscribe: If you would like to be removed from our mailing list, please send your contact information to CASL.unsubscribe at legrand.ca<mailto:casl.unsubscribe@legrand.ca> and indicate what messages you no longer wish to receive.
