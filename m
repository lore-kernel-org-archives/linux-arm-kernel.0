From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Oct 2018 22:00:10 +0100 (CET)
Subject: [PATCH RFC 11/18] staging: vchiq_arm: use completions instead
 of semaphores
In-Reply-To: <20181026134813.7775-12-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-12-nsaenzjulienne@suse.de>
Message-ID: <646164838.4217.1540760410870@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> It is preferred in the kernel to avoid using semaphores to wait for
> events, as they are optimised for the opposite situation; where the
> common case is that they are available and may block only occasionally.
> FYI see this thread: https://lkml.org/lkml/2008/4/11/323.
> 
> Also completions are semantically more explicit in this case.
> 

Since patch #11 #12 and #13 doing the same, they could be fold.
