From: psodagud@codeaurora.org (Prasad Sodagudi)
Date: Mon, 20 Mar 2017 09:36:16 -0700
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <alpine.DEB.2.20.1703171416060.3538@nanos>
References: <alpine.DEB.2.20.1703171416060.3538@nanos>
Message-ID: <1490027777-29130-1-git-send-email-psodagud@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irq_do_set_affinity() last argument differentiates whether notify work 
need to queued for this irq or not.  So that we can avoid double queuing of notify
in the irq_set_affinity_locked() path.
