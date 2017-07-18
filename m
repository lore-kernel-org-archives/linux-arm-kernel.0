From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Jul 2017 17:26:32 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
In-Reply-To: <dada875c-ed69-0126-8e83-78a564e6b4bd@codeaurora.org>
References: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
 <20170717224551.GA1496@localhost.localdomain>
 <6d10032c-35ec-978c-6b8f-1ab9c07adf7f@codeaurora.org>
 <20170717225615.GB1496@localhost.localdomain>
 <79413407294645f0e1252112c3435a29@codeaurora.org>
 <20170718143617.GA7613@localhost.localdomain>
 <dada875c-ed69-0126-8e83-78a564e6b4bd@codeaurora.org>
Message-ID: <20170718212631.GB1202@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 02:52:26PM -0400, Sinan Kaya wrote:
> On 7/18/2017 10:36 AM, Keith Busch wrote:
> 
> I do see that the NVMe driver is creating a completion interrupt on
> each CPU core for the completions. No problems with that. 
> 
> However, I don't think you can guarantee that there will always be a single
> CPU core targeting one submission queue especially with asynchronous IO.
>
> Lock contention counters from CONFIG_LOCK_STAT are pointing to nvmeq->lock
> in my FIO tests.
> 
> Did I miss something?

I think that must mean your machine has many more CPUs than your nvme
controller has IO queues.
