From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 12:33:49 +0100
Subject: [PATCH v2 1/3] nvmem: core: make default user binary file
 root-access only
In-Reply-To: <1444215647-10836-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444215647-10836-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20151007113349.GJ21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 12:00:47PM +0100, Srinivas Kandagatla wrote:
> As required by many providers like at24/at25/mxs-ocotp/qfprom and may be
> other providers would want to allow root-only to read the nvmem content.
> So making the defaults to be root-only access would address the request
> and also provide flexibility to providers to specify there own permissions
> on top of the root-only using the perm flag in nvmem_config.
> Making this dynamic did cut down lot of static binary attributes in the
> code.

Check what the lifetime of a struct bin_attribute is before you embed it
into any other structure.  Sorry, but I think you're going to have to
read up on the driver model, sysfs, and kernfs implementations to find
out - I don't know the answer to this without doing the same.

However, this is basic checking that anyone should do when embedding
a structure within another.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
