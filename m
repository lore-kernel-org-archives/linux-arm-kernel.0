From: davem@davemloft.net (David Miller)
Date: Wed, 30 Aug 2017 10:46:08 -0700 (PDT)
Subject: [PATCH v7 07/11] sparc64: optimized struct page zeroing
In-Reply-To: <e07c05b1-c0be-bf7f-9a29-11dc41b79d10@oracle.com>
References: <1503972142-289376-8-git-send-email-pasha.tatashin@oracle.com>
 <20170829.181208.171985548699678313.davem@davemloft.net>
 <e07c05b1-c0be-bf7f-9a29-11dc41b79d10@oracle.com>
Message-ID: <20170830.104608.2080967179463692935.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 30 Aug 2017 09:19:58 -0400

> The reason I am not doing initializing stores is because they require
> a membar, even if only regular stores are following (I hoped to do a
> membar before first load). This is something I was thinking was not
> true, but after consulting with colleagues and checking processor
> manual, I verified that it is the case.

Oh yes, that's right, now I remember.
