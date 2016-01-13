From: pablo@netfilter.org (Pablo Neira Ayuso)
Date: Wed, 13 Jan 2016 17:49:03 +0100
Subject: [PATCH] netfilter: nft_ct: mark nft_ct_get_eval_counter
 __maybe_unused
In-Reply-To: <20160113155424.GA1581@salvia>
References: <6200241.eeH6DHXzHj@wuerfel>
 <20160113155424.GA1581@salvia>
Message-ID: <20160113164903.GA4121@salvia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 04:54:24PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Jan 13, 2016 at 02:58:11PM +0100, Arnd Bergmann wrote:
> > The newly added nft_ct_get_eval_counter() function is only used when
> > CONFIG_NF_CONNTRACK_LABELS is set, otherwise gcc warns about the
> > unused definition:
> > 
> > netfilter/nft_ct.c:34:12: warning: 'nft_ct_get_eval_counter' defined but not used [-Wunused-function]
> >  static u64 nft_ct_get_eval_counter(const struct nf_conn_counter *c,
> > 
> > This marks the function __maybe_unused to shut up the warning.
> 
> It seems that function doesn't below to CONFIG_NF_CONNTRACK_LABELS as
> it is part of the new counter support. Will be sending an alternate
> patch instead.

Just for the record, I submitted this fix:

http://patchwork.ozlabs.org/patch/567063/
