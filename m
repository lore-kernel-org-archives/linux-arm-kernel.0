From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 11 Oct 2017 10:08:21 +0000
Subject: [PATCH v2] xdp: Sample xdp program implementing ip forward
In-Reply-To: <20171010210607.2af452e2@redhat.com>
References: <1507620532-25804-1-git-send-email-Christina.Jacob@cavium.com>
 <1507620532-25804-2-git-send-email-Christina.Jacob@cavium.com>
 <20171010210607.2af452e2@redhat.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0090EEE@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jesper Dangaard Brouer
> Sent: 10 October 2017 20:06
...
> > +		int src_ip = 0, dest_ip = 0;
...
> > +			key4.b8[4] = dest_ip % 0x100;
> > +			key4.b8[5] = (dest_ip >> 8) % 0x100;
> > +			key4.b8[6] = (dest_ip >> 16) % 0x100;
> > +			key4.b8[7] = (dest_ip >> 24) % 0x100;

Do you really want signed remainders done here?

	David
