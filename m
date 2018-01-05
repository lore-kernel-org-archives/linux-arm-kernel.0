From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 5 Jan 2018 14:24:56 +0100
Subject: [PATCH 12/12] power: reset: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20180105132456.GD2614@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2018 at 14:28:08 +0100, Julia Lawall wrote:
> This driver creates a const structure that it stores in the data
> field of an of_device_id array.
> 
> Add const to the declaration of the location that receives a value
> from the data field to ensure that the compiler will continue to check
> that the value is not modified and remove the const-dropping cast on
> the access to the data field.
> 
> Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
