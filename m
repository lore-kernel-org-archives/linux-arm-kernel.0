From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 12:04:15 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C47A6CDC@dbde02.ent.ti.com>
References: <4B9DB823.1040809@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C47A6C90@dbde02.ent.ti.com>
	<4B9DC28F.3060209@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C47A6CDC@dbde02.ent.ti.com>
Message-ID: <4B9DD4E7.3060308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2010 10:58 AM, Shilimkar, Santosh wrote:
>> > But the standard drivers which are already in mainline may not support these platform
>> > data.
>> > 
> Driver won't change major way. I was saying passing additional information via
> platform data to drivers. Even with Kconfig stuff, you need to touch drivers to take care of
> your exceptions.
> 
> Am I missing something?

We need only a platform specific function (spear300_configure), that will take care of this.
We don't need to change anything in driver for this. I feel Driver is not supposed to know
what platform specific configuration is required to enable the device.
