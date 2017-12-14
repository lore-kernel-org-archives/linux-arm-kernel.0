From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Thu, 14 Dec 2017 12:28:50 +0200
Subject: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <CAJZ5v0inHMCLGyPaAeuJNo2VH7f3Th0KdpT2UkPBCsvrSDi0gQ@mail.gmail.com>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
 <20171207124044.utyrn2mzzyml42b2@valkosipuli.retiisi.org.uk>
 <c2b38889-888a-3518-bf59-c2377f64a8ce@codeaurora.org>
 <20171207220642.qqiwf4vvk2gf42uf@valkosipuli.retiisi.org.uk>
 <CAJZ5v0inHMCLGyPaAeuJNo2VH7f3Th0KdpT2UkPBCsvrSDi0gQ@mail.gmail.com>
Message-ID: <20171214102849.fqselexjzfh63ytd@paasikivi.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 11:19:51PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 7, 2017 at 11:06 PM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > On Thu, Dec 07, 2017 at 03:17:52PM -0500, Sinan Kaya wrote:
> >> On 12/7/2017 7:40 AM, Sakari Ailus wrote:
> >> > On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
> >> >> @@ -101,6 +103,8 @@ struct fwnode_operations {
> >> >>    (*graph_get_port_parent)(struct fwnode_handle *fwnode);
> >> >>    int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
> >> >>                                struct fwnode_endpoint *endpoint);
> >> >> +  void *(*get_match_data)(const struct fwnode_handle *fwnode,
> >> >> +                          struct device *dev);
> >> >
> >> > You can make dev const, too.
> >> >
> >>
> >> done, I couldn't change device_get_match_data() parameter const due to
> >> dev_fwnode() function.
> >>
> >>                  from /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:13:
> >>
> >> /local/mnt/workspace/projects/caf/kernel/drivers/base/property.c:1341:39: warning: passing argument 1 of 'dev_fwnode' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >>   return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data,
> >
> > Right. Makes sense.
> >
> > I guess it's not perhaps worth it introducing dev_fwnode_const just for
> > this. devices are seldom if ever const anyway.
> 
> They cannot be const.  Had they been const, it wouldn't have been
> possible to register them even. :-)

In general no, but this function does not change the device in any way,
therefore it could be const in principle.

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
