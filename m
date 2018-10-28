From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Oct 2018 21:45:39 +0100 (CET)
Subject: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
In-Reply-To: <20181026134813.7775-10-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-10-nsaenzjulienne@suse.de>
Message-ID: <1781917429.4071.1540759539282@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> vchiq_init_state() initialises a series of semaphores to then call
> remote_event_create() on the same semaphores, which initializes them
> again.

i would prefer to have all init stuff at one place in vchiq_init_state() and drop this ugliness from remote_event_create() instead. Is this possible?
