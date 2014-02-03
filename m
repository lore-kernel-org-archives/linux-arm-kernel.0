From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Feb 2014 10:46:41 +0000
Subject: [PATCH V3 5/5] ARM CoreSight: ETM: Add PID control support
In-Reply-To: <1391098270-8867-6-git-send-email-adrienverge@gmail.com>
References: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
 <1391098270-8867-6-git-send-email-adrienverge@gmail.com>
Message-ID: <20140203104641.GB12187@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 04:11:10PM +0000, Adrien Verg? wrote:
> In the same manner as for enabling tracing, an entry is created in
> sysfs to set the PID that triggers tracing. This change is effective
> only if CONFIG_PID_IN_CONTEXTIDR is set.
> 
> When using PID namespaces, the virtual PID given by the user is
> converted to the globally unique ID (task_pid_nr) that is present
> in the Context ID register.

Hmm, I wonder whether debugfs would be more suitable for this?

Will
