From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 17 Dec 2015 12:07:12 -0500
Subject: -next regression: "driver cohandle -EPROBE_DEFER from
 bus_type.match()"
In-Reply-To: <CAPcyv4h1yhyqxdyLka2X56Q5QhCoXY3vALFBdm0gdQdYR6Vr8w@mail.gmail.com>
References: <CAPcyv4hOJuT=i2A_0vDQHsL7MXNgVN_p17q3UW6EcTkxsCMmeg@mail.gmail.com>
 <CAPcyv4h1yhyqxdyLka2X56Q5QhCoXY3vALFBdm0gdQdYR6Vr8w@mail.gmail.com>
Message-ID: <20151217170712.GE2457@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 08:48:09AM -0800, Dan Williams wrote:
> On Thu, Dec 17, 2015 at 7:51 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> How about just checking for EPROBE_DEFER, every other non-zero value is success.

How about using IS_ERR_VALUE()?  If it's good enough for IS_ERR(),
it's good enough for this case.
