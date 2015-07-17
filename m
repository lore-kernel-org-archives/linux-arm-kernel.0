From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 17 Jul 2015 15:45:34 +0100
Subject: [Xen-devel] [PATCH v2 09/20] xen/biomerge: Don't allow biovec
 to be merge when Linux is not using 4KB page
In-Reply-To: <55A914D5.7080900@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-10-git-send-email-julien.grall@citrix.com>
 <20150710191245.GA31063@l.oracle.com>
 <alpine.DEB.2.02.1507161627010.17378@kaball.uk.xensource.com>
 <55A7D8AD.1090102@citrix.com>
 <alpine.DEB.2.02.1507171418260.17378@kaball.uk.xensource.com>
 <55A914D5.7080900@citrix.com>
Message-ID: <alpine.DEB.2.02.1507171545170.17378@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015, Julien Grall wrote:
> On 17/07/15 14:20, Stefano Stabellini wrote:
> > We would have to run some benchmarks, but I think it would still be a
> > win. We should write an ad-hoc __pfn_to_mfn translation function that
> > operates on a range of pfns and simply checks whether an entry is
> > present in that range. It should be just as fast as __pfn_to_mfn. I
> > would definitely recommend it.
> 
> I'd like to see a basic support of 64KB support on Xen pushed in Linux
> upstream before looking to possible improvement in the code. Can we
> defer this as the follow-up of this series?

Yes, maybe add a TODO comment in the code. 
