From: P.Bruenn@beckhoff.com (=?utf-8?B?UGF0cmljayBCcsO8bm4=?=)
Date: Thu, 30 Nov 2017 13:36:22 +0000
Subject: [PATCH] rtc: add mxc driver for i.MX53
In-Reply-To: <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
>Sent: Donnerstag, 30. November 2017 09:18
>>
>>> +/*
>>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
>Reserved.
>>> + */
>>> +
>>> +/*
>>> + * The code contained herein is licensed under the GNU General Public
>>> + * License. You may obtain a copy of the GNU General Public License
>>> + * Version 2 or later at the following locations:
>>> + *
>>> + * http://www.opensource.org/licenses/gpl-license.html
>>> + * http://www.gnu.org/copyleft/gpl.html
>>> + */
>
>Exactly!
>And while you are it , you could replace the boilerplate license text
>with the SPDX id.
>--

How would a perfect header look like?
Looking at :
git show b24413180f5600bcb3bb70fbed5cf186b60864bd -- drivers/
and:
git grep SPDX -- Documentation/

it could be:
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
+ */
or:
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
+ */

Personally I would prefer:
+/*
+ * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */

So, is there any guideline?

To be clear: I don't want to waste anyone's time on this. But as SPDX
was intended for automation, I think it might be good to try having
some common pattern here.
I don't want to start a discussion, so in case there is no guideline I will
just take the /* SPDX */ in firstline version.

Regards, Patrick

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
