From: bhe@redhat.com (Baoquan He)
Date: Tue, 27 Nov 2018 15:15:25 +0800
Subject: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
In-Reply-To: <20181127064816.GE1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181126012824.GB1824@MiWiFi-R3L-srv>
 <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
 <20181127064816.GE1824@MiWiFi-R3L-srv>
Message-ID: <20181127071525.GF1824@MiWiFi-R3L-srv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/18 at 02:48pm, Baoquan He wrote:
 
> #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
> 	VMCOREINFO_SYMBOL(node_data);
	^^^ 

> #endif

Wrong copy
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
	VMCOREINFO_NUMBER(page_offset_base);

#endif
