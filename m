From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Oct 2018 14:16:02 +0100
Subject: [RFC PATCH] skb: Define NET_IP_ALIGN based on
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
In-Reply-To: <CAKv+Gu9MBJ0w+23XMg+w_EYEf0Hx8dkW-w-rf4Bzu_c3GN_YiQ@mail.gmail.com>
References: <20181004173631.3nchegr6rm3jgz24@xylophone.i.decadent.org.uk>
 <CAKv+Gu9MBJ0w+23XMg+w_EYEf0Hx8dkW-w-rf4Bzu_c3GN_YiQ@mail.gmail.com>
Message-ID: <20181005131601.GE14398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 07:43:59PM +0200, Ard Biesheuvel wrote:
> (+ Arnd, Russell, Catalin, Will)
> 
> On 4 October 2018 at 19:36, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> > NET_IP_ALIGN is supposed to be defined as 0 if DMA writes to an
> > unaligned buffer would be more expensive than CPU access to unaligned
> > header fields, and otherwise defined as 2.
> >
> > Currently only ppc64 and x86 configurations define it to be 0.
> > However several other architectures (conditionally) define
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, which seems to imply that
> > NET_IP_ALIGN should be 0.
> >
> > Remove the overriding definitions for ppc64 and x86 and define
> > NET_IP_ALIGN solely based on CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> >
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> While this makes sense for arm64, I don't think it is appropriate for
> ARM per se.

Agreed that this makes sense for arm64, and I'd be happy to take a patch
defining it as 0 there.

Will
