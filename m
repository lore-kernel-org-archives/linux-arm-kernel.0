From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 1 Sep 2015 18:10:29 +0100
Subject: [PATCH v3 19/20] xen/privcmd: Add support for Linux 64KB page
 granularity
In-Reply-To: <alpine.DEB.2.02.1508101230260.11337@kaball.uk.xensource.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-20-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508101230260.11337@kaball.uk.xensource.com>
Message-ID: <55E5DC05.2080701@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 10/08/15 13:03, Stefano Stabellini wrote:
>> +			xen_pfn = xen_page_to_pfn(page);
>> +		}
>> +		fn(pfn_to_gfn(xen_pfn++), data);
> 
> What is the purpose of incrementing xen_pfn here?

Because the Linux page is split into multiple xen_pfn, so we want to get
the next xen_pfn for the next iteration.

Regards,

-- 
Julien Grall
