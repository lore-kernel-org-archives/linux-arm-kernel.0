From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Thu, 9 Nov 2017 02:38:06 +0100
Subject: [PATCH v4 1/1] xdp: Sample xdp program implementing ip forward
In-Reply-To: <20171108.104024.315386187840767748.davem@davemloft.net>
References: <1509852150-1466-1-git-send-email-christina.jacob.koikara@gmail.com>
 <1509852150-1466-2-git-send-email-christina.jacob.koikara@gmail.com>
 <20171108.104024.315386187840767748.davem@davemloft.net>
Message-ID: <20171109023806.36b38f0c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Nov 2017 10:40:24 +0900 (KST)
David Miller <davem@davemloft.net> wrote:

> From: Christina Jacob <christina.jacob.koikara@gmail.com>
> Date: Sun,  5 Nov 2017 08:52:30 +0530
> 
> > From: Christina Jacob <Christina.Jacob@cavium.com>
> > 
> > Implements port to port forwarding with route table and arp table
> > lookup for ipv4 packets using bpf_redirect helper function and
> > lpm_trie  map.
> > 
> > Signed-off-by: Christina Jacob <Christina.Jacob@cavium.com>  
> 
> Applied to net-next, thank you.

I've not had time to proper test (and review) this V4 patch, but I
guess I'll have to do so when I get home from Seoul...

I especially want to measure the effect of using bpf_redirect_map().
To Christina: what performance improvement did you see on your
board/arch when switching from bpf_redirect() to bpf_redirect_map()?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
