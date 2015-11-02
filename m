From: cl@linux.com (Christoph Lameter)
Date: Mon, 2 Nov 2015 10:10:23 -0600 (CST)
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
Message-ID: <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 1 Nov 2015, Jungseok Lee wrote:

> There is no room to adjust 'atom_size' now when a generic percpu area
> is used. It would be redundant to write down an architecture-specific
> setup_per_cpu_areas() in order to only change the 'atom_size'. Thus,
> this patch adds a new definition, PERCPU_ATOM_SIZE, which is PAGE_SIZE
> by default. The value could be updated if needed by architecture.

What is atom_size? Why would you want a difference allocation size here?
The percpu area is virtually mapped regardless. So you will have
contiguous addresses even without atom_size.
