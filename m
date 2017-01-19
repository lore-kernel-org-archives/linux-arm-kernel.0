From: jk@ozlabs.org (Jeremy Kerr)
Date: Thu, 19 Jan 2017 10:11:16 +0800
Subject: [PATCH v2 15/18] drivers/fsi: Add documentation for GPIO based
 FSI master
In-Reply-To: <20170118215755.xoamoc2rrzhy4kyz@rob-hp-laptop>
References: <1484260543-80300-1-git-send-email-christopher.lee.bostic@gmail.com>
 <20170118215755.xoamoc2rrzhy4kyz@rob-hp-laptop>
Message-ID: <f0933f56-6a23-9c53-6e10-0e1ca18082e2@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

>From this:

>> +
>> +The standard FSI master node
>> +----------------------------
>> +This node describes a FSI master implmemented fully in hardware
>> +with dedicated input/output pins required for its function (i.e.
>> +not using generic GPIO pins).
>> +Required property:
>> +	compatible = "ibm,fsi-master"

and this:

>> +Example:
>> +
>> +fsi-master {
>> +	compatible = "ibm,fsi-master-gpio", "ibm,fsi-master";
> 
> From the description, these should be mutually exclusive.

I agree with Rob here. The intention is for "ibm,fsi-master" to be an
abstract master -- simply indicating that this node describes a master,
with no specific implementation, and "ibm,fsi-master-gpio" to be a
GPIO-based implementation. A hardware-based FSI master would have a
different compatible value, based on the hardware.

We should remove references to implementations in the "The standard FSI
master node" section, because this is independent of implementation.

>> +	clk-gpios = <&gpio 0>, <&gpio 6>;
>> +	data-gpios = <&gpio 1>, <&gpio 7>;
>> +	enable-gpios = <&gpio 2>, <&gpio 8>;
>> +	trans-gpios = <&gpio 3>, <&gpio 9>;
>> +	mux-gpios = <&gpio 4>, <&gpio 10>;

Do we support multiple-link masters? This example implies a 2-link
master.

Cheers,


Jeremy
