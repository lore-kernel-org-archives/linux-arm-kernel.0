From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 27 Oct 2014 17:34:26 -0700
Subject: [RFC 4/7] soc: qcom: Add Shared Memory Manager driver
In-Reply-To: <5435AD8E.2000109@codeaurora.org>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-5-git-send-email-bjorn.andersson@sonymobile.com>
 <5435AD8E.2000109@codeaurora.org>
Message-ID: <20141028003424.GP28611@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 08 Oct 14:33 PDT 2014, Jeffrey Hugo wrote:

[..]
> > + */
> > +struct smem_header {
> > +     struct smem_proc_comm proc_comm[4];
> > +     u32 version[32];
> > +     u32 smem_initialized;
> > +     u32 free_offset;
> > +     u32 available;
> > +     u32 unused;
> 
> I see that you inlined the smem_heap_info struct.  That is slightly
> problematic since we have some uses of that structure, and without it,
> accessing id 1 becomes complicated.  I would prefer you reintroduce it.
> 

Could you help me better understand what you mean here? I've scanned through
msm-3.4 and msm-3.10 and read your comment numerous times, but I can't find any
uses that needs it nor figure out why it would be difficult to access item 1.

> > +     struct smem_entry toc[SMEM_MAX_ITEMS];
> > +};

Thanks,
Bjorn
