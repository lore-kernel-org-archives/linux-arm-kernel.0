From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 15 Mar 2010 10:27:42 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing)	in linux
In-Reply-To: <4B9DB823.1040809@st.com>
References: <4B9DB823.1040809@st.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C47A6C90@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Viresh KUMAR
> Sent: Monday, March 15, 2010 10:02 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Armando VISCONTI; 'Shiraz HASHIM'
> Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing) in linux
> 
> Hello everybody,
> 
> In our SOC's (SPEArxxx), we have many peripheral sharing PL_GPIO pins and so
> only few peripherals can be selected in a configuration. This is configurable
> using a set of registers. Now the problem is to make following work:
> 
> 1. How to do this selection in kernel in a simple way?
> 2. Based on this selection hardware registers needs to be configured.
> 
> I propose following solution to solve this issue, but i am not sure if it is
> acceptable by community.
> 
> Please see if it is fine. Or if there is any other way people may already be
> following for similar issues.
> 
> I have provided this selection from "make menuconfig", based on selection I
> configure hardware at initialization time. Basically these selections will
> decide which device is present in the system when it boots.
> 
> There are modes in which SOC can be configured and in these modes
> peripherals can be selected.
> 
Since the data is board dependent, why don't you make this information as platform
data for devices and pass that information from board files depending on board type.

This gives you flexibility as well and you don't need unnecessary cluttering of
Kconfig entries.

- Santosh
