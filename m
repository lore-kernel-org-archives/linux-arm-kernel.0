From: keith.busch@intel.com (Keith Busch)
Date: Mon, 17 Jul 2017 18:45:51 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
In-Reply-To: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
References: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170717224551.GA1496@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 06:36:23PM -0400, Sinan Kaya wrote:
> Code is moving the completion queue doorbell after processing all completed
> events and sending callbacks to the block layer on each iteration.
> 
> This is causing a performance drop when a lot of jobs are queued towards
> the HW. Move the completion queue doorbell on each loop instead and allow new
> jobs to be queued by the HW.

That doesn't make sense. Aggregating doorbell writes should be much more
efficient for high depth workloads.
