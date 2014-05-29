From: rientjes@google.com (David Rientjes)
Date: Thu, 29 May 2014 12:37:38 -0700 (PDT)
Subject: [PATCH] CMA: correct unlock target
In-Reply-To: <1401344958-3790-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1401344958-3790-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.02.1405291237280.28588@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 May 2014, Joonsoo Kim wrote:

> 'cma: Remove potential deadlock situation' introduces per cma area mutex
> for bitmap management. It is good, but there is one mistake. When we
> can't find appropriate area in bitmap, we release cma_mutex global lock
> rather than cma->lock and this is a bug. So fix it.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: David Rientjes <rientjes@google.com>
