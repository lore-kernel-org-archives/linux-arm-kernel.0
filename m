From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 07 Jan 2014 15:11:48 -0800
Subject: [PATCH v2 1/5] mm: create generic early_ioremap() support
In-Reply-To: <1389062120-31896-2-git-send-email-msalter@redhat.com>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-2-git-send-email-msalter@redhat.com>
Message-ID: <52CC89B4.4060300@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 06:35 PM, Mark Salter wrote:
> 
> There is one difference from the existing x86 implementation which
> should be noted. The generic early_memremap() function does not return
> an __iomem pointer and a new early_memunmap() function has been added
> to act as a wrapper for early_iounmap() but with a non __iomem pointer
> passed in. This is in line with the first patch of this series:
> 

This makes a lot of sense.  However, I would suggest that we preface the
patch series with a single patch changing the signature for the existing
x86 function, that way this change becomes bisectable.

	-hpa
