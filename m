From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 18:13:14 +0100
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141106143217.GA3636@gondor.apana.org.au>
References: <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
 <20141031081803.GA8012@gondor.apana.org.au>
 <20141031095706.GA8054@lukather>
 <20141031100522.GA8655@gondor.apana.org.au>
 <20141103093446.GG11263@lukather>
 <20141103103528.GA30154@gondor.apana.org.au>
 <20141106142633.GK2989@lukather>
 <20141106143217.GA3636@gondor.apana.org.au>
Message-ID: <20141116171314.GN6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 10:32:18PM +0800, Herbert Xu wrote:
> On Thu, Nov 06, 2014 at 03:26:33PM +0100, Maxime Ripard wrote:
> > 
> > But you still haven't explain why the driver, while it doesn't handle
> > the user space buffer at any time, should be worried that the data the
> > framework has given him are actually mapped.
> 
> Encryption is used by IPsec and SKBs can be allocated in highmem.
> algif also exposes all ciphers to user-space memory which can also
> be in highmem.

Ok. We keep going in circles here.

I know that algif handles userspace memory that can be in
highmem. What I don't get, is that just like a *driver* doesn't have
to call copy_from_user, why would it need to call kmap...

That's something that should be in the framework itself, not the
driver. And the argument that most drivers use DMA seems like a broken
assumption.

But hey, you're the one that will maintain this mess, so I guess you
have the final word.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/d38a98f2/attachment.sig>
