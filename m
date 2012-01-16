From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Jan 2012 13:08:30 -0700 (MST)
Subject: [PATCH v6 0/6] PM QoS: implement the OMAP low level constraints
 management code
In-Reply-To: <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
 <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
 <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201161305451.16675@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jan 2012, Jean Pihet wrote:

> Speaking of the locking, currently a spinlock is used and it could be
> replaced by a more efficient mutex. 

Just a minor observation.  It's not so much that the mutex is more 
efficient.  It's just that mutexes allow interrupt processing on that CPU 
while they are held, unlike spinlocks.  So the use of spinlocks can 
increase the latency to service an interrupt request.  We'd like to keep 
that latency as low as possible.


- Paul
