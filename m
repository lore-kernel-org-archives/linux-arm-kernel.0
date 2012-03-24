From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Sat, 24 Mar 2012 13:48:23 +0100
Subject: [PATCH 07/10] um: Should hold tasklist_lock while traversing
 processes
In-Reply-To: <20120324103030.GG29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
Message-ID: <1332593303.16159.28.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-03-24 at 14:30 +0400, Anton Vorontsov wrote:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe. 

No it doesn't, it either requires tasklist_lock or rcu_read_lock().
