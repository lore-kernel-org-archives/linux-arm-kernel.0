Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7332CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435EA217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WuChJ4Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435EA217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zuc8Qyyn6wbao/PTi+yPB/IFhO73WI8ZRAzM37/uH6o=; b=WuChJ4Wcb2VtsM
	AEgz2M/Z/h+mr9w1FJhOcaggDWt6iDQ0sLvxL4l5o7+/Jw2kWZRKgHCuOwWlgAm7MNC3CR1gHMqeM
	GT4gbbct7f9tEp64C+4NfrgbTSNEAjE9q/h2TUqdHa+BXWV29mwxgU4vCPmLDPcV0MorW8v3Ru7YD
	QUaph3S9ocHPo7SmTSTp6eNdLblAFKzej+oxxh6+5lf4boBHIEyTUc0uVf78rxIrwwHvq0M3hctZw
	syKzv710pmLoQW43YPvQNAsX4dbfIU8iyihKog7awUElqutmVmD5oxfvFQBBR00EQjABW7N/b0Ssy
	J7qr+CgjD0o+1LZKNEcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBXy-0003s3-1L; Tue, 18 Dec 2018 09:20:14 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBWI-0002OK-CD; Tue, 18 Dec 2018 09:18:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id BDFC82027DA8E; Tue, 18 Dec 2018 10:18:24 +0100 (CET)
Date: Tue, 18 Dec 2018 10:18:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181218091824.GI2218@hirez.programming.kicks-ass.net>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20181217225020.GA16520@hirez.programming.kicks-ass.net>
 <20181218000800.GB25620@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218000800.GB25620@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 04:08:00PM -0800, Andi Kleen wrote:
> On Mon, Dec 17, 2018 at 11:50:20PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 20, 2018 at 10:59:47PM +0100, Arnd Bergmann wrote:
> > > Hi Nico, all,
> > > 
> > > I was playing with ARM link-time optimization handling earlier this
> > > month, and eventually got it to build cleanly with randconfig kernels,
> > > but ended up with a lot of ugly hacks to actually pull it off.
> > 
> > How are we dealing with the fact that LTO can break RCU in very subtle
> > and scary ways?
> > 
> > Do we have a compiler guy on board that has given us a compiler switch
> > that kills that optimization (and thereby guarantees that behaviour for
> > future compilers etc..) ?
> 
> Can you actually define what optimization you are worred about?
> 
> If there are optimizations that cause problems they likely happen
> even without LTO inside files. The only difference with LTO is that it
> does them between files too.

In particular turning an address-dependency into a control-dependency,
which is something allowed by the C language, since it doesn't recognise
these concepts as such.

The 'optimization' is allowed currently, but LTO will make it much more
likely since it will have a much wider view of things. Esp. when combined
with PGO.

Specifically; if you have something like:

int idx;
struct object objs[2];

the statement:

  val = objs[idx & 1].ponies;

which you 'need' to be translated like:

  struct object *obj = objs;
  obj += (idx & 1);
  val = obj->ponies;

Such that the load of obj->ponies depends on the load of idx. However
our dear compiler is allowed to make it:

  if (idx & 1)
    obj = &objs[1];
  else
    obj = &objs[0];

  val = obj->ponies;

Because C doesn't recognise this as being different. However this is
utterly broken, because in this translation we can speculate the load
of obj->ponies such that it no longer depends on the load of idx, which
breaks RCU.

Note that further 'optimization' is possible and the compiler could even
make it:

  if (idx & 1)
    val = objs[1].ponies;
  else
    val = objs[0].ponies;

Now, granted, this is a fairly artificial example, but it does
illustrate the exact problem.

The more the compiler can see of the complete program, the more likely
it can make inferrences like this, esp. when coupled with PGO.

Now, we're (usually) very careful to wrap things in READ_ONCE() and
rcu_dereference() and the like, which makes it harder on the compiler
(because 'volatile' is special), but nothing really stops it from doing
this.

Paul has been trying to beat clue into the language people, but given
he's been at it for 10 years now, and there's no resolution, I figure we
ought to get compiler implementations to give us a knob.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
