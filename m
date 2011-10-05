From: mst@redhat.com (Michael S. Tsirkin)
Date: Wed, 5 Oct 2011 08:39:45 -0200
Subject: [PATCH] virtio: Add platform bus driver for memory mapped virtio
	device
In-Reply-To: <87aa9ggs4k.fsf@rustcorp.com.au>
References: <1317217663-32647-1-git-send-email-pawel.moll@arm.com>
	<878vp1iqpz.fsf@rustcorp.com.au>
	<1317745002.3158.340.camel@hornet.cambridge.arm.com>
	<87aa9ggs4k.fsf@rustcorp.com.au>
Message-ID: <20111005103944.GB5587@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2011 at 11:40:51AM +1030, Rusty Russell wrote:
> The absolute maximum is a ring of 32k elements, which is about 850k.
> That seems a little excessive, though.

Given that it must be physically contigious and each descriptor
is 64 byte in size + space for used and avail rings, yes it does :)
