From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 22 Nov 2013 16:37:14 -0800
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <528FF402.6000503@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-12-git-send-email-swarren@wwwdotorg.org>
 <CAPcyv4heN3PFc+n2RDBviA0zvyU4jfi5VLOcQVR6oRPi1woPTA@mail.gmail.com>
 <1384766276.14845.155.camel@smile> <528A5170.3090809@wwwdotorg.org>
 <1384862421.14845.222.camel@smile> <528B9CAE.3040600@wwwdotorg.org>
 <CAPcyv4jR2MufF6PqB3cUwNdQZfzGWVdj1UunBkeyMYm-KvkpCQ@mail.gmail.com>
 <528BFDD0.3090503@wwwdotorg.org>
 <CAPcyv4i7o0RP4ovG1S8RbiV9wqV+VZWX+2vBm3iKnVLCYfrnBQ@mail.gmail.com>
 <528CFE68.6060908@wwwdotorg.org>
 <CAPcyv4hjJDOq+qEvuCG32PLQcWeHVyeVDCy=5UM8KX445OxY_w@mail.gmail.com>
 <528D0C06.9080006@wwwdotorg.org>
 <1384979000.2067.5.camel@dwillia2-mobl1.amr.corp.intel.com>
 <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4gmo0k3n8==0oEs4NMKbEH4F9xHutRTURE7sVe=M7xwRg@mail.gmail.com>
 <528FF402.6000503@wwwdotorg.org>
Message-ID: <CAPcyv4g9y_R9acd5OOiYZJaxvvd-TYKw2DoFV5qF3cbuQpB9jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 4:17 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> No, it's a bug because if dma_request_slave_channel() is documented to
> return valid-or-ERR, then assuming that it can never return NULL is
> inconsistent with that. The translation is only possible if it's
> documented to return valid-or-ERR-but-never-NULL.

Yes!  We are in violent agreement about this point.  Make
dma_request_slave_channel return valid-or-ERR-but-never-NULL, and show
me the compat user that would care if it got an EPROBE_DEFER instead
of ENODEV.
