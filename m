From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 18 Jan 2018 00:12:18 +0100
Subject: [PATCH 07/12] i2c: rk3x: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20180117231218.e3xa5vq4mg6b6kta@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 02:28:03PM +0100, Julia Lawall wrote:
> This driver creates a number of const structures that it stores in
> the data field of an of_device_id array.
> 
> The data field of an of_device_id structure has type const void *, so
> there is no need for a const-discarding cast when putting const values
> into such a structure.
> 
> Furthermore, adding const to the declaration of the location that
> receives a const value from such a field ensures that the compiler
> will continue to check that the value is not modified.  The
> const-discarding cast on the extraction from the data field is thus
> no longer needed.
> 
> Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/4b380b13/attachment.sig>
