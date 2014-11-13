From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Nov 2014 14:12:48 +0530
Subject: [PATCH 2/3] coresight: fixed comments in coresight.h
In-Reply-To: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
References: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1415868169-13325-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fixes following minor issues in code comments in coresight.h
- typo %s/enpoint/endpoint
- alignment of comment section for struct coresight_desc
- correction of comment for struct coresight_connection and
  struct coresight_device.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 include/linux/coresight.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bdde419..5d3c543 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -87,7 +87,7 @@ struct coresight_dev_subtype {
  * @cpu:	the CPU a source belongs to. Only applicable for ETM/PTMs.
  * @name:	name of the component as shown under sysfs.
  * @nr_inport:	number of input ports for this component.
- * @outports:	list of remote enpoint port number.
+ * @outports:	list of remote endpoint port number.
  * @child_names:name of all child components connected to this device.
  * @child_ports:child component port number the current component is
 		connected  to.
@@ -113,7 +113,7 @@ struct coresight_platform_data {
 		by @coresight_ops.
  * @pdata:	platform data collected from DT.
  * @dev:	The device entity associated to this component.
- * @groups	:operations specific to this component. These will end up
+ * @groups:	operations specific to this component. These will end up
 		in the component's sysfs sub-directory.
  */
 struct coresight_desc {
@@ -127,7 +127,6 @@ struct coresight_desc {
 
 /**
  * struct coresight_connection - representation of a single connection
- * @ref_count:	keeping count a port' references.
  * @outport:	a connection's output port number.
  * @chid_name:	remote component's name.
  * @child_port:	remote component's port number @output is connected to.
@@ -143,6 +142,7 @@ struct coresight_connection {
 
 /**
  * struct coresight_device - representation of a device as used by the framework
+ * @conns:	array of coresight_connections associated to this component.
  * @nr_inport:	number of input port associated to this component.
  * @nr_outport:	number of output port associated to this component.
  * @type:	as defined by @coresight_dev_type.
-- 
1.7.9.5
